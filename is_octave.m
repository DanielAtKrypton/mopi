function r = is_octave()
%IS_OCTAVE Summary of this function goes here
persistent x;
if (isempty (x))
  x = exist ('OCTAVE_VERSION', 'builtin');
end
r = x;
