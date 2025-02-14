%% R1.a)
[killing_me_softly, Fs] = audioread('fugee.wav');
soundsc(killing_me_softly, Fs);

%% R1.b)
t = 1:length(killing_me_softly);
plot(t, killing_me_softly); %plot the signal

%% R1.c)
w = -pi:2*pi/length(killing_me_softly):pi;
w = w(:, 1:end-1);
semilogy(w, fftshift(abs(fft(killing_me_softly)))); %plot the signal magnitude spectrum

%% R2.a)
[b, a] = butter(10, 0.5);
[h, w] = freqz(b, a);
plot(w, abs(h)); %plot the filter's frequency response

%% R2.b)
[b, a] = butter(10, 0.5);
killing_me_softly_butter = filter(b, a, killing_me_softly); %low-pass filter the signal

%% R2.c)
killing_me_softly = audioread('fugee.wav');
t = 1:length(killing_me_softly);
plot(t, killing_me_softly, 'b');
hold on;
plot(t, killing_me_softly_butter, 'r'); %plot the filtered signal over the unfiltered one

%% R2.d)
killing_me_softly = audioread('fugee.wav');
w = -pi:2*pi/length(killing_me_softly):pi;
w = w(:, 1:end-1);
semilogy(w, fftshift(abs(fft(killing_me_softly))), 'b');
hold on
semilogy(w, fftshift(abs(fft(killing_me_softly_butter))), 'r'); %plot the filtered signal magnitude spectrum over the unfiltered one

%% R2.e)
killing_me_softly = audioread('fugee.wav');
[b, a] = butter(10, 0.5);
killing_me_softly_butter = filter(b, a, killing_me_softly);
soundsc(killing_me_softly_butter); 

%% R2.f)
w_cf = 0.25; %or 0.75 for the cut off frequency
[b, a] = butter(10, w_cf);
killing_me_softly = audioread('fugee.wav');
killing_me_softly_butter = filter(b, a, killing_me_softly); %low-pass filter the signal

%% R3.b)
killing_me_softly = audioread('fugee.wav');
killing_me_softly_median3 = medfilt1(killing_me_softly);
t = 1:length(killing_me_softly);
plot(t, killing_me_softly, 'b');
hold on;
plot(t, killing_me_softly_median3, 'g'); %plot the filtered signal over the unfiltered one

%% R3.c)
killing_me_softly = audioread('fugee.wav');
w = -pi:2*pi/length(killing_me_softly):pi;
w = w(:, 1:end-1);
semilogy(w, fftshift(abs(fft(killing_me_softly))), 'b');
hold on
semilogy(w, fftshift(abs(fft(killing_me_softly_median3))), 'g'); %plot the filtered signal magnitude spectrum over the unfiltered one

%% R3.d)
killing_me_softly = audioread('fugee.wav');
killing_me_softly_median3 = medfilt1(killing_me_softly);
soundsc(killing_me_softly_median3);

%% R3.e)
n = 2; %order
killing_me_softly = audioread('fugee.wav');
killing_me_softly_medianN = medfilt1(killing_me_softly, n); %filter the signal with a n-th order median filter
soundsc(killing_me_softly_medianN);
