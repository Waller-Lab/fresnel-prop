function cplot(f)

figure; subplot(2,1,1); imagesc(abs(f));colorbar;axis image
title('amplitude')
subplot(2,1,2);imagesc(angle(f));colorbar;axis image
title('phase')