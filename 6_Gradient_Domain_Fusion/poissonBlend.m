% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function im_blend = poissonBlend(im_src, mask_src, im_trg)

src = im_src;
trg = im_trg;
msk = mask_src;
[imh, imw, ~] = size(src);
[yy, xx] = find(msk > 0);
var = sum(sum(msk));
im2var = zeros(imh, imw);
i = 1;

for j=1:var
    im2var(yy(j),xx(j)) = i;
    i = i + 1;
end

im_blend = im_trg;
A = sparse([], [], []);
B = zeros(var, 3);
e = 1;

for j=1:var
    y = yy(j);
    x = xx(j);
    A(e,im2var(y,x)) = 4;
    if (msk(y-1,x) == 1)
        A(e,im2var(y-1,x)) = -1;
        for i = 1:3
            B(e,i) = B(e,i) - (src(y-1,x,i) - src(y,x,i));
        end
    else
        for i = 1:3
            B(e,i) = B(e,i) + trg(y-1,x,i);
        end
    end
    if (msk(y+1,x) == 1)
        A(e,im2var(y+1,x)) = -1;
        for i = 1:3
            B(e,i) = B(e,i) - (src(y+1,x,i) - src(y,x,i));
        end
    else
        for i = 1:3
            B(e,i) = B(e,i) + trg(y+1,x,i);
        end
    end
    if (msk(y,x-1) == 1)
        A(e,im2var(y,x-1)) = -1;
        for i = 1:3
            B(e,i) = B(e,i) - (src(y,x-1,i) - src(y,x,i));
        end
    else
        for i = 1:3
            B(e,i) = B(e,i) + trg(y,x-1,i);
        end
    end
    if (msk(y,x+1) == 1)
        A(e,im2var(y,x+1)) = -1;
        for i = 1:3
            B(e,i) = B(e,i) - (src(y,x+1,i) - src(y,x,i));
        end
    else
        for i = 1:3
            B(e,i) = B(e,i) + trg(y,x+1,i);
        end
    end
    e = e + 1;
end
Xr = A\B(:,1);
Xg = A\B(:,2);
Xb = A\B(:,3);
Xr(Xr < 0) = 0;
Xg(Xg < 0) = 0;
Xb(Xb < 0) = 0;

e = 1;
for i=1:var
    y = yy(i);
    x = xx(i);
    im_blend(y,x,1) = Xr(e);
    im_blend(y,x,2) = Xg(e);
    im_blend(y,x,3) = Xb(e);
    e = e + 1;
end