
for i = 1:1:1000
    sno = i;
    VV = V(:, sno);
    VV1 = V1(:, sno);
    VV1cor = V1correct(:, sno);

    Vvec = 1:1:length(VV);
    plot(Vvec, VV, 'r');
    hold on;
    plot(Vvec, VV1, 'k');
    plot(Vvec, VV1cor, 'b');
    hold off;
end
