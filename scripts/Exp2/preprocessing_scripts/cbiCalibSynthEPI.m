function cbiCalibSynthEPI(rhoName, boName, rsName, TE, kyDir, synthName, bInitialBoEffect)
% Synthesize an EPI image at the desired TE from calibration data
% rhoName:
%    nifti file rho estimate from calibration scan
% boName:
%    nifti file B0 estimate from calibration scan
%    could be regularized
% rsName:
%    nifti file R2star estimate from calibration scan
%    could be regularized
% kyDir:
%     0 indicates setting B0=0, i.e. T2* only
%    +1 indicates conventional readout
%    -1 indicates reversed readout
% TE:
%    desired TE in units of echo spacing
% bInitialBoEffect (0 (default) or 1):
%    whether to take into effect Bo phase evolution at the beginning of the
%    readout or not.  Using it gives better match in the distortions, but 
%    if the field estimate is not right that initial phase evolution will 
%    create ringing artifacts in the dropout areas, so you should disable
%    it.
%
% Note:
%   this program assumes that the EPI and the calibration scan have
%   the same acquisition protocol, i.e. FOV, resolution, echo-spacing, 
%   phase encode direction, etc.)

% check bInitialBoEffect:
if (nargin<7)
  bInitialBoEffect = 0;    % default
else
  if ( (bInitialBoEffect==0) || (bInitialBoEffect==1) )
    % you're good to go
  else
    warning('Unknown value for bInitialBoEffect.  Using default (bInitialBoEffect=0)')
    bInitialBoEffect = 0;
  end
end

% Load the parameter estimates
nfd = niftifile(rhoName);
nfd = fopen(nfd,'read');
[nfd, rho] = fread(nfd,nfd.nx*nfd.ny*nfd.nz);
rho = reshape(rho, nfd.nx, nfd.ny, nfd.nz);
nfd = fclose(nfd);

nfd = niftifile(boName);
nfd = fopen(nfd,'read');
[nfd, bo] = fread(nfd,nfd.nx*nfd.ny*nfd.nz);
bo = reshape(bo, nfd.nx, nfd.ny, nfd.nz);
nfd = fclose(nfd);

nfd = niftifile(rsName);
nfd = fopen(nfd,'read');
[nfd, rs] = fread(nfd,nfd.nx*nfd.ny*nfd.nz);
rs = reshape(rs, nfd.nx, nfd.ny, nfd.nz);
nfd = fclose(nfd);

% switch the sign of B0 depending on the readout direction
switch kyDir
    case 0
        bo = 0.0*bo;
    case 1
        % do nothing
    case -1
        % reverse
        bo = -bo;
    otherwise
        % error
        error('kyDir should be 0, +1 or -1')
end

% Open the output file
nfd = niftifile(synthName,nfd);
nfd.descrip = 'NYU CBI synthetic EPI image';
nfd = fopen(nfd,'write');

% Forward model and inverse
% see recon code for sign convention, etc.
% we're going to apply the matrices on the right
% The fourier operator
Ny = double(nfd.ny);
ky = (-Ny/2 : Ny/2-1)';
y  = (-Ny/2 : Ny/2-1)'/Ny;
zFy = zeros(Ny,Ny);
for n = 1:Ny
   zFy(:,n) = exp(2*pi*1i*ky(n)*y(:));
end
% inverse is the adjoint
zPFy = zFy';
% forward is the integeral
zFy = 1/Ny * zFy;

% tStart (first ky line, in units of Echo Spacing):
tStart = TE - Ny/2;

% Loop over the slices and process one at a time
epi = zeros(size(rho));
for nz = 1:nfd.nz
    rhoslice = rho(:,:,nz);
    boslice  = bo(:,:,nz);
    rsslice  = rs(:,:,nz);
    data = zeros(nfd.nx,Ny);
    brfactor = exp(1i*boslice - rsslice);
    % should we consider the phase evolution at the beginning of the
    %   readout?
    if (bInitialBoEffect==0)
      % ignore it.  This fixes a weird artifact in the synthetic data
      %   if bo is not exactly right
      bors = exp(-(tStart-1)*rsslice);    % just 1 ES before beginning of readout.
    else
      bors = exp((tStart-1)*(1i*boslice-rsslice));    % just 1 ES before beginning of readout.
    end
    
    for n = 1:Ny
        bors = bors.*brfactor;
        data(:,n) = (bors.*rhoslice)*zFy(:,n); % zFy was transposed!
    end
    epi(:,:,nz) = abs(data * zPFy);
end

% Write to disk
nfd = fwrite(nfd, single(abs(epi)), nfd.nx*nfd.ny*nfd.nz);
fclose(nfd);

