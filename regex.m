function [matched, before, after] = regex(inputString, pattern, varargin)
%REGEX Summary of this function goes here
%   Detailed explanation goes here
inputString = char(inputString);
pattern = char(pattern);
switch nargin
case 2
    modifier = 'g';
case 3
    modifier = varargin{1};
otherwise
    error('Wrong number of inputs!')
end
resultingString = perl('regexpScript.pl', inputString, pattern, modifier);
result = split(resultingString,compose(["\r\n", "\n", "\r"]));
matched = result{1};
before = result{2};
after = result{3};



