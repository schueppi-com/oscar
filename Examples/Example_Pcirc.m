clearvars; close all;
addpath(genpath(strcat(pwd, '\..\Classes')));

disp('---------------------------------------------------------------------------')
disp('                  OSCAR V3.20                                      ')
disp('  ')


% Define the grid for the simulation: 128 X 128, 15 cm X 15 cm
G1 = Grid(128,0.15);

% Define the incoming beam on the input mirror surface (beam radius 2 cm,
% wavefront curvature 2000 m, propagating toward the waist)
E_input = E_Field(G1,'w',0.02,'R',-2000);
% The beam is defined outside the cavity, must take into account
% !! the transmission of the input mirror acting as a lens !!
% possibility to define the input beam directly inside the cavity if needed

% Define the 2 mirrors, RofC = 2500m, 10 cm in diameter, transmission 2%,
% no loss

IM = Interface(G1,'RoC',2500,'CA',0.10,'T',0.02);
EM = Interface(G1,'RoC',2500,'CA',0.10,'T',0.02);

% Use the 2 previous Interfaces and the input beam to defing a cavity 1000
% meter long
C1 = Cavity1(IM,EM,1000,E_input);

% Calculate the resonance length
C1 = Cavity_resonance_phase(C1);

 % Display information about the cavity
Get_info(C1)

