function dy = diffFD(y,dt)
    %   FREQUENCY-DOMAIN DIFFERENTATION 
    % from https://uk.mathworks.com/matlabcentral/fileexchange/58944-difffd
    %
    %
    %   Computes derivative of discrete time-signal in frequency domain by 
    %   multiplying specturm with iw (i x omega) 
    %
    %   Syntax:    
    %        dy = diffFD(y, dt)
    %
    %   Input: 
    %         y = input signal to be differentiated in time
    %
    %        dt = sampling interval (e.g., 0.01 s for 100 samples-per-second)
    %                                    
    %        dy = time derivative of input signal
    %
    %   Example: Input is 15 Hz sinusoidal signal sampled at 200 sps;
    %   compare frequency-domain differentiation with analytical solution
    %
    %       n = 128;
    %       dt = 1/200;
    %       t = dt*(0:n-1);
    %       T = dt*n;
    %       y = sin(2*pi*15*t/T);
    %       dy = diffFD(y,dt);
    %       dy_analyt = cos(2*pi*15*t/T)*(2*pi*15/T);
    %       figure; subplot(2,1,1); plot(t,real(dy),'b',t,dy_analyt,'r');
    %       legend('diffFD','analytical');
    %       subplot(2,1,2); plot(t,dy_analyt-dy); ylabel('error');
    %
    %   See also inteFD 
    %
    %   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER "AS IS" AND ANY
    %   EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    %   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
    %   PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER BE LIABLE
    %   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
    %   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
    %   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
    %   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
    %   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
    %   OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
    %   ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    %
    %   Written by Dr. Erol Kalkan, P.E. (ekalkan@usgs.gov)
    %   $Revision: 2.0.1 $  $Date: 2019/02/13 9:22:00 $
    %
    % enforce input as row vector
    if ~isrow(y); y = y'; end
    % Calculate length of the time record
    n = length(y);
    T = dt*n; 
    % Compute shifted FFT
    z = fftshift(fft(y));
    df = 1/T;
    if ~mod(n,2)
        f = df*(-n/2:n/2-1); % n is even
    else
        f = df*(-(n-1)/2:(n-1)/2); % n is odd
    end
    w = 2*pi*f;
    % Compute inverse FFT
    dy = ifft(ifftshift(z.*(1i*w)));