% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function fnc = adpmedian(I, max)
if (max <= 1) || (max/2 == round(max/2)) || (max ~= round(max))
   error('MAX must be an odd integer > 1.')
end

fnc = I;
fnc(:) = 0;
alreadyProcessed = false(size(I));

for d = 3:2:max
   zmin = ordfilt2(I, 1, ones(d, d), 'symmetric');
   zmax = ordfilt2(I, d*d, ones(d, d), 'symmetric');
   zmed = medfilt2(I, [d d], 'symmetric');
   
   processUsingLevelB = (zmed > zmin) & (zmax > zmed) & ...
       ~alreadyProcessed; 
   zB = (I > zmin) & (zmax > I);
   outputZxy  = processUsingLevelB & zB;
   outputZmed = processUsingLevelB & ~zB;
   fnc(outputZxy) = I(outputZxy);
   fnc(outputZmed) = zmed(outputZmed);
   
   alreadyProcessed = alreadyProcessed | processUsingLevelB;
   if all(alreadyProcessed(:))
      break;
   end
end

fnc(~alreadyProcessed) = zmed(~alreadyProcessed);