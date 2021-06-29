%% UV Dosage Standard Operation
clear;
clc;

P = 22.5; %Nominal Power of Lamp at End of Life (W)
R = 3.81; %Chamber Radius (cm)
R_L = 2.54; %Lamp Radius (cm)
L = 50; %Length of Lamp (cm)
T_water = .95; %UV Transmittance
refl_SS = .30; %Max UV Reflectance for SS
T_Silica = .95; %Max UV Transmittance for Quartz Silica Sleeve
t = .3; %Thickness of quartz sleeve (cm)
alpha = log(T_water);
I_0 = T_Silica * (P / (2 * R_L * pi * L)); %Initial Intensity (W/cm^2)
x = R_L:.0001:R; %cm
I_xout = I_0 * (R_L ./ x) .* exp(alpha * (x-R_L)); %Intensity for Outward Propogation (W/cm^2)
I_wall = I_0 * (R_L / R) * exp(alpha * (R-R_L)); %Intensity at the Wall (W/cm^2)
I_0back = refl_SS * I_wall; %Initial Intensity for Inward Propogation (W/cm^2)
I_xback = I_0back * (R ./ x) .* exp(alpha * (abs(x-R))); %Intensity for Inward Propogation (W/cm^2)
I_total = I_xout + I_xback; %Total Intensity (W/cm^2)
I_mean = mean(I_total); %Average Intensity (W/cm^2) (Can assume this for turbulent flow)


UVD = .016; %UV Dosage Standard (J/cm^2)
t = UVD / I_mean; %Time of treatment needed (s)

A_c = (R^2 - R_L^2) * pi; %Chamber Area (cm^2)
v = L / t; %Inlet Velocity (cm/s)
Q = A_c * v * .015850323; %Flow Rate (gpm)


