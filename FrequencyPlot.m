%% clear old data
clear all; close all; clc

%% Select and open audio file
[FileName, PathName]= uigetfile('*') ;
File = [PathName, '\' , FileName];
[data, fs] = audioread(File);


% %%
% X1 = fftshift( data(:, 1));
% X2 = fftshift( data(:, 2));

%%
L = length(data);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y

Y1 = fft(data(:,1),NFFT)/L;
X1 = fs/2*linspace(0,1,NFFT/2+1);

Y2 = fft(data(:,2),NFFT)/L;
X2 = fs/2*linspace(0,1,NFFT/2+1);

%% Plot single-sided amplitude spectrum.
figure
subplot(2,1,1)
    loglog(X1,2*abs(Y1(1:NFFT/2+1)))    
    xlabel('Frequency (Hz)')
    ylabel('|Y(f)|')
    % set(gca, 'XLim', [5 max(get(gca,'xlim'))]);
    set(gca, 'XLim', [5 (10^ceil(log10(max(X1))))]);
    grid on

title(FileName)
    
subplot(2,1,2)
    loglog(X2,2*abs(Y2(1:NFFT/2+1))) 
    xlabel('Frequency (Hz)')
    ylabel('|Y(f)|')
    % set(gca, 'XLim', [5 max(get(gca,'xlim'))]);
    set(gca, 'XLim', [5 (10^ceil(log10(max(X2))))]);
    grid on
% title('Single-Sided Amplitude Spectrum of y(t)')

%% Save emf plot in the same location as the music file
if File(end-3) == '.'
    saveas(gcf, [ File(1:end-3) , 'emf'])
elseif File(end-4) == '.'
     saveas(gcf, [ File(1:end-4) , 'emf'])
end

% close graph
close gcf