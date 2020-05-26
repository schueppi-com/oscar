clearvars; close all;
addpath(genpath(strcat(pwd, '\..\Classes')));

disp('---------------------------------------------------------------------------')
disp('                  OSCAR V3.21                                     ')
disp('  ')


% Define the grid for the simulation: 256 X 256, 15 cm X 15 cm
G1 = Grid(256,0.15);

% Define the incoming beam outside the input mirror (beam radius 2 cm), at
% the waist

E_input = E_Field(G1,'w0',0.022);
E_input = Add_Sidebands(E_input,3.4E6,0.2);

% Imperfect mode matching and the beam will be also be slightly clipped on
% the end mirror (diffraction loss of 1700 ppm)

% Define the 2 mirrors, one flat and the other with a RoC of 2400m, 10 cm in diameter, transmission 2% and 0.1%,
% no loss

IM = Interface(G1,'RoC',inf,'CA',0.1,'T',0.02);
EM = Interface(G1,'RoC',2400,'CA',0.1,'T',0.001);


% Use the 2 previous Interfaces and the input beam to defing a cavity 1000
% meter long
C1 = Cavity1(IM,EM,1000,E_input);

% Calculate the resonance length
C1 = Cavity_resonance_phase(C1);

% Display the circulating power, reflected and transmitted powers

tic
C2 = Calculate_fields_AC(C1);
disp('Accelerated convergence results:')
AC_time = toc;
C2.Display_results();


tic
C3 = Calculate_fields(C1,'accuracy',0.00001);
disp('Normal convergence results:')
NC_time = toc;
C3.Display_results();


fprintf('\n Computational speed gain: %3.2g \n', NC_time/AC_time )

% [a,b] = Calculate_Power(C2.Field_circ,'include','SB','SB_num',1)
% [a,b] = Calculate_Power(C3.Field_circ,'include','SB','SB_num',1)
% 
% Field_total = Normalise_E(E_input,0);
% E_Plot(Field_total,'Field','SB')
