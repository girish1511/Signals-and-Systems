1.Run the code as it as and you will get the graphs given in the report.
2.Remove comment (‘%’)  before the subplot command and comment the command ‘figure’ to get all the graphs in a single plot (like Fig 10 in the report).
3.Carrier and message frequencies can be changed by the changing the values of fc and fm respectively but make sure that both the frequencies are not close and fc>fm.
4.Sampling rate can be changed by altering the variable t.
5.The plots shown only a section of the whole signal(-0.5s to 0.5s). To view the full graph comment the axis() function below every plot() function.

Variables:

fc->carrier frequency
fm->message frequency
A->amplitude of message signal
wc->angular frequency of carrier
wm->angular frequency of message
m->message signal
c->carrier signal
mod->modulated signal
demod->demodulated signal (before low pass filter)
y->demodulated signal (afterglow pass filter)

Functions used:
plot()
subplot()
xlabel()
ylabel()
title()
legend()
axis()
figure
hold
gird
butter()