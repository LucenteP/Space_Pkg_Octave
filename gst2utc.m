function dateUTC = gst2utc(dateGST, format)
  % This function permitts to convert from Galileo System time to UTC format.
  % The GST date can be given in hex or bin or dec format
  % The UTC date is always a vector of 6 elements: [year month day hour minute seconds]
  % NO 18 leap seconds are considered

% Example:
% dateGST=['0x5493172C'];
% format = 'hex';
  switch format
    case 'hex'
      % hex_string=['0x5493172C'];
      if strcmpi(dateGST(1:2),'0x')
        % 0x è un prefisso che va tolto
        hex_string = dateGST(3:end);
        else
          hex_string = dateGST;
      end
    GSTbin = hex2bin (hex_string);
    WN_str = num2str(GSTbin(1:12))(num2str(GSTbin(1:12)) != ' ');
    ToW_str = num2str(GSTbin(13:32))(num2str(GSTbin(13:32)) != ' ');
    WN = bin2dec( WN_str );
    ToW = bin2dec( ToW_str );
  case 'bin'
    if ischar(dateGST)
      WN_str = dateGST(1:12);
      ToW_str = dateGST(13:32);
    elseif isnumeric(dateGST)
      WN_str = num2str(dateGST(1:12))(num2str(dateGST(1:12)) != ' ');
      ToW_str = num2str(dateGST(13:32))(num2str(dateGST(13:32)) != ' ');
    end
    WN = bin2dec( WN_str );
    ToW = bin2dec( ToW_str );
case 'dec'
    WN = dateGST(1);
    ToW = dateGST(2);
  end

leap_sec = 18;
delta_sec = WN*7*86400+ToW ;
delta_days = delta_sec / 86400;
gal_epoch = [1999, 8, 22, 0, 0, 0]; % Galileo Start Epoch in UTC
t0 = datenum(gal_epoch);            % Galileo epoch in serial date number
t1 = t0 + delta_days;
dateUTC = datevec(t1);

end


