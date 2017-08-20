% Calculated weighted P-wave velocity

function Vp = get_weighted_Vp(W, n, ...
                    rho_bulk, ...
                    rho1, V1, C1,...
                    rho2, V2, C2,...
                    rho3, V3, C3,...
                    rho4, V4, C4,...
                    phi, Sh)
                
                %rho_bulk = C1.*rho1 + C2.*rho2 + C3.*rho3 + C4.*rho4;
                

   Vw1 = C1 ./ (rho1 .* V1 .* V1);
   Vw2 = C2 ./ (rho2 .* V2 .* V2);
   Vw3 = C3 ./ (rho3 .* V3 .* V3);
   Vw4 = C4 ./ (rho4 .* V4 .* V4);
   Vwood = sqrt(1 ./ (rho_bulk .* (Vw1 + Vw2 + Vw3 + Vw4)));
   
   if phi > 1
       %phi = 1;
   end
   if Vwood < 0
       %disp('NEGATIVE ENCOUNTERED');
   end
   
   Vwy = 1 ./ (C1./V1 + C2./V2 + C3./V3 + C4./V4);
   if Vwy < 0
       %disp('NEGATIVE ENCOUNTERED');
   end
   
   Vinv = W * phi.*((1 - Sh).^n) ./ Vwood + (1 - W .* phi.*((1 - Sh).^n)) ./ Vwy;
   Vp = 1 ./ Vinv;
   
end
   