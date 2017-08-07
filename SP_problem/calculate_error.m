function error = calculate_error(paramV)

paramV
[Xreal, Vreal] = textread('real_data.dat', '%f%f');

Vg = SP_sphere(Xreal, paramV(1), paramV(2), paramV(3), paramV(4), paramV(5));

error = 2*sum(abs(Vreal-Vg))/(sum(abs(Vreal-Vg)) + sum(abs(Vreal+Vg)));



misfit = sqrt(sum(((Vreal-Vg)./Vreal).^2))*100/length(Vreal)



end