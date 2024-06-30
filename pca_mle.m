clear all;

P1 = getMarketDataViaYahoo('QCOM','1-Jan-2002','31-Dec-2022','1mo');
P2 = getMarketDataViaYahoo('TSM','1-Jan-2002','31-Dec-2022','1mo');
P3 = getMarketDataViaYahoo('INTC','1-Jan-2002','31-Dec-2022','1mo');
P4 = getMarketDataViaYahoo('AMD','1-Jan-2002','31-Dec-2022','1mo');
P5 = getMarketDataViaYahoo('NOVT','1-Jan-2002','31-Dec-2022','1mo');
P6 = getMarketDataViaYahoo('TXN','1-Jan-2002','31-Dec-2022','1mo');
P7 = getMarketDataViaYahoo('NVDA','1-Jan-2002','31-Dec-2022','1mo');
P8 = getMarketDataViaYahoo('ASML','1-Jan-2002','31-Dec-2022','1mo');
P9 = getMarketDataViaYahoo('MCHP','1-Jan-2002','31-Dec-2022','1mo');
P10 = getMarketDataViaYahoo('ON','1-Jan-2002','31-Dec-2022','1mo');
R1 = 100*(P1.Close(2:end) - P1.Close(1:end-1)) ./ P1.Close(1:end-1);
R2 = 100*(P2.Close(2:end) - P2.Close(1:end-1)) ./ P2.Close(1:end-1);
R3 = 100*(P3.Close(2:end) - P3.Close(1:end-1)) ./ P3.Close(1:end-1);
R4 = 100*(P4.Close(2:end) - P4.Close(1:end-1)) ./ P4.Close(1:end-1);
R5 = 100*(P5.Close(2:end) - P5.Close(1:end-1)) ./ P5.Close(1:end-1);
R6 = 100*(P6.Close(2:end) - P6.Close(1:end-1)) ./ P6.Close(1:end-1);
R7 = 100*(P7.Close(2:end) - P7.Close(1:end-1)) ./ P7.Close(1:end-1);
R8 = 100*(P8.Close(2:end) - P8.Close(1:end-1)) ./ P8.Close(1:end-1);
R9 = 100*(P9.Close(2:end) - P9.Close(1:end-1)) ./ P9.Close(1:end-1);
R10 = 100*(P10.Close(2:end) - P10.Close(1:end-1)) ./ P10.Close(1:end-1);

R1 = (R1 - mean(R1))/std(R1);
R2 = (R2 - mean(R2))/std(R2);
R3 = (R3 - mean(R3))/std(R3);
R4 = (R4 - mean(R4))/std(R4);
R5 = (R5 - mean(R5))/std(R5);
R6 = (R6 - mean(R6))/std(R6);
R7 = (R7 - mean(R7))/std(R7);
R8 = (R8 - mean(R8))/std(R8);
R9 = (R9 - mean(R9))/std(R9);
R10 = (R10 - mean(R10))/std(R10);
dates = P1.Date;
dates2 = dates(2:end,:);

R = [R1,R2,R3,R4,R5,R6,R7,R8,R9,R10];
[B,F,var] = pca(R);
fprintf('\n');
fprintf('PCA eigenvalues\n');
disp(var);
fprintf('\n');
fprintf('PCA eigenvectors (first 2)\n');
disp(B(:,1:2));
F1 = F(:,1);
F2 = F(:,2);
ex1=var(1,:)/10;
ex2=var(2,:)/10;

[B,sig,T,stats,FF] = factoran(R,2);
fprintf('Factor Analysis Beta\n');
disp(B);
fprintf('\n');
fprintf('variances\n');
disp(sig);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function data=getMarketDataViaYahoo(symbol, startdate, enddate, interval)
    if(nargin() == 1)
        startdate = posixtime(datetime('1-Jan-2018'));
        enddate = posixtime(datetime()); % now
        interval = '1d';
    elseif (nargin() == 2)
        startdate = posixtime(datetime(startdate));
        enddate = posixtime(datetime()); % now
        interval = '1d';
    elseif (nargin() == 3)
        startdate = posixtime(datetime(startdate));
        enddate = posixtime(datetime(enddate));        
        interval = '1d';
    elseif(nargin() == 4)
        startdate = posixtime(datetime(startdate));
        enddate = posixtime(datetime(enddate));
    else
        error('At least one parameter is required. Specify ticker symbol.');
        data = [];
        return;
    end
    
    %% Send a request for data
    % Construct an URL for the specific data
    uri = matlab.net.URI(['https://query1.finance.yahoo.com/v7/finance/download/', upper(symbol)],...
        'period1',  num2str(int64(startdate), '%.10g'),...
        'period2',  num2str(int64(enddate), '%.10g'),...
        'interval', interval,...
        'events',   'history',...
        'frequency', interval,...
        'guccounter', 1,...
        'includeAdjustedClose', 'true');  
    
    options = weboptions('ContentType','table', 'UserAgent', 'Mozilla/5.0');
    try
        data = rmmissing(webread(uri.EncodedURI, options));
    catch ME
        data = [];
        warning(['Identifier: ', ME.identifier, 'Message: ', ME.message])
    end 
end

