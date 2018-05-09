%% R1.b)
load("energy_train.mat");
N = 96;
a = longtermpred(x_train, N);
figure
plot(x_train(N+1:end));
x_pred = a*x_train(1:end-N);
figure
plot(x_pred);
r = x_train(N+1:end)-x_pred;
figure
plot(r)

%% R1.c)
load("energy_train.mat");
N = 96;
a = longtermpred(x_train, N);
x_pred = a*x_train(1:end-N); %this was (N+1:end), so not like above
r = x_train(N+1:end)-x_pred;
E = sum(r.^2);

%% R1.e)
load("energy_train.mat");
P = 5;
a = shorttermpred(r, P);
figure
plot(r(P+1:end));
r_pred = zeros(size(r, 1) - P, 1);
for i = P+1:size(r_pred, 1)
    s = 0;
    for k = 1:P
        s = s + a(k)*r(i-P+k-1);
    end
    r_pred(i-P) = s;
end
figure
plot(r_pred);

x_pred = x_train(N+P+1:end) + r_pred; %x_train(N+P+1, end) = nothing??
figure
plot(x_pred); 
e = r(P+1:end)-r_pred;

figure
plot(e);


%% R1.f)
load("energy_train.mat");
P = 5;
a = shorttermpred(r, P);
r_pred = zeros(size(r, 1) - P, 1);
for i = P+1:size(r_pred, 1)
    s = 0;
    for k = 1:P
        s = s + a(k)*r(i-P+k-1);
    end
    r_pred(i-P) = s;
end

e = r(P+1:end)-r_pred;
E = sum(e.^2);

%% R2.b)
load("energy_test.mat");
plot(x_test);
P = 10;
a = shorttermpred(x_test, P);
x_pred = zeros(size(x_test, 1) - P, 1);
for i = 1+P:size(x_pred, 1)
    s = 0;
    for k = 1:P
        s = s + a(k)*x_test(i-P+k-1);
    end
    x_pred(i-P) = s;
end
figure;
plot(x_pred);
e = x_test(P+1:end)-x_pred;
figure;
plot(e);

%% longterm
load("energy_test.mat");
plot(x_test);
N = 96;
a = longtermpred(x_test, N);
x_pred = a*x_test(1:end-N); %this was (N+1:end), so not like above
figure;
plot(x_pred);
r = x_test(N+1:end)-x_pred;
figure;
plot(r);