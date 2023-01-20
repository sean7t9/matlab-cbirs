% function [Precision,Recall] = PrecisionRecall ()
prompt = {'Enter space-separated numbers of relevant matches for all 6 categories (ex. 9 10 7...):',...
          'Enter the number of returned images:',...
          'Enter the total images per category:'};
dlgtitle = 'Input';
dims = [1 50];
definput = {'','10','20'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
I_correct = str2num(answer{1});
I_returned = str2double(answer{2});
% I_returned = length(ten_best_D);
I_TIC = str2double(answer{3});

Precision = I_correct/I_returned;
Recall = I_correct/I_TIC;
plot(Recall,Precision);


% end