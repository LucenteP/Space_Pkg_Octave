function GST = utc2gst(dateUTC, format)
  % Esempio di uso:
% dateUTC = [2025 07 09 08 15 00];
% GST = utc2gst(dateUTC)
% INPUT Format
 % dateUTC = [year, month, day, hour, min, sec]

  % Galileo epoch: 22 August 1999, 00:00:00 UTC
  gal_epoch = [1999, 8, 22, 0, 0, 0];

  % Convert both dates to serial days
  t0 = datenum(gal_epoch);         % Galileo epoch in serial date number
  t1 = datenum(dateUTC);           % Input date in serial date number

  % Difference in days and seconds
  delta_days = t1 - t0;
  % 86400 sec in 1 day
  delta_seconds = delta_days * 86400;

  % Week Number (WN) and Time of Week (ToW)
  WN = floor(delta_seconds / (7*86400));
  ToW = mod(delta_seconds, 7*86400);

  switch format
    case 'bin'
        ToW = dec2bin(ToW,20);
        WN = dec2bin(WN,12);
end

  GST = [WN, ToW];


end


