


@_deferred = []
@_errormsg = nil
@_finished = nil

begin

  begin
    undef :defer
    undef :reject
    undef :finish
  rescue
  end

  def defer(&i)
    @_deferred.push( i )
  end

  def reject(*i)
    if !i || i[0]
      @_errormsg = i[1] if i[1]
      throw :paramout
    end
  end

  def finish(*i)
    if i.size
      @_finished = i
    else
      @_finished = true
    end
  end

  @unused = []
  @cache  = {}
  _FOUND_ = {}
  _errors = 0
  _invalid = {}
  _lastprefix = nil

  _pos     = 0   # current position to match from
  _nextpos = 0   # next position to match from

  catch(:alldone) do 
    while !@_finished
      begin
	catch(:arg) do
	  @_errormsg = nil

	  # This is used for clustering of flags
	  while _lastprefix
	    substr = _args[_nextpos..-1]
	    substr =~ /^(?!\s|\0|\Z)(?!\-i)(?!\-q)/ or
	      begin 
		_lastprefix=nil
		break
	      end
	    "#{_lastprefix}#{substr}" =~ /^((?:\-i|\-q))/ or
	      begin 
		_lastprefix=nil
		break
	      end
	    _args = _args[0.._nextpos-1] + _lastprefix + _args[_nextpos..-1]
	    break
	  end #  while _lastprefix

	  
	  _pos = _nextpos if _args

	  usage(0) if _args && gindex(_args,/\G(-help|--help|-Help|--Help|-HELP|--HELP|-h|-H)(\s|\0|\Z)/,_pos)
          version(0) if _args && _args =~ /\G(-version|--version|-Version|--Version|-VERSION|--VERSION|-v|-V)(\s|\0|\Z)/
      
          catch(:paramout) do
            while !_FOUND_['-i']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G[\s|\0]*\-i/, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-i' parameter|
                  end

                  _PARAM_ = '-i'

                 _args && _pos = gindex( _args, /\G[\s|\0]*((?:(?!\-i)(?!\-q)(?:(?:[+-]?)(?:\d)+)))/x, _pos ) or throw(:paramout)
	          _VAR_ = %q|<iterations>|
	          _VAL_ = @@m[0]
	          _VAL_.tr!("\0"," ") if _VAL_
	          _VAL_ = _VAL_.to_i if _VAL_

		  begin
                        reject( _VAL_ <= 0, 
                                   "in parameter '#{_PARAM_}' (#{_VAL_} must be an integer greater than zero)")
		  end
		  iterations = _VAL_

                  if _invalid.has_key?('-i')
                    @_errormsg = %q|parameter '-i' not allowed with parameter '| + _invalid['-i'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-i'
                    end
                  end  #if/then

		  @cache['-i'] = iterations
                  _lastprefix = "\-"

                  _FOUND_['-i'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.size
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-q']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G[\s|\0]*\-q/, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-q' parameter|
                  end

                  _PARAM_ = '-q'

                 _args && _pos = gindex( _args, /\G/x, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-q')
                    @_errormsg = %q|parameter '-q' not allowed with parameter '| + _invalid['-q'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-q'
                    end
                  end  #if/then


                  @cache['-q'] = '-q'
                  _lastprefix = "\-"

                  _FOUND_['-q'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.size
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)


	if _lastprefix
           _pos = _nextpos + _lastprefix.length()
	   _lastprefix = nil
	   next
        end

	  _pos = _nextpos

	  _args && _pos = gindex( _args, /\G[\s|\0]*(\S+)/, _pos ) or throw(:alldone)

	  if @_errormsg
             $stderr.puts( "Error#{source}: #{@_errormsg}\n" )
          else
             @unused.push( @@m[0] )
          end

	  _errors += 1 if @_errormsg

        end  # catch(:arg)

      ensure  # begin
        _pos = 0 if _pos.nil?
	_nextpos = _pos if _args
	if _args and _args.index( /\G(\s|\0)*\Z/, _pos )
	  _args = _get_nextline.call(self) if !@_finished
          throw(:alldone) unless _args
          _pos = _nextpos = 0
          _lastprefix = ''
	end   # if
      end   # begin/ensure
    end   # while @_finished
  end   # catch(:alldone)
end  # begin


if _FOUND_['-q'] && !(_FOUND_['-i'])
   $stderr.puts "Error#{@source}: parameter '-q' can only be specified with '-i'"
   _FOUND_['-q'] = nil
   @args['-q'] = nil
   _errors += 1
end
            
#################### Add unused arguments
if _args && _nextpos > 0 && _args.length() > 0
    @unused.replace( @unused + _args[_nextpos..-1].split(' ') )
end

for i in @unused
    i.tr!( "\0", " " )
end


#################### Print help hint
if _errors > 0 && !@source.nil?
  $stderr.puts "\n(try '#$0 -help' for more information)"
end

## cannot just assign unused to ARGV in ruby
unless @source != ''
  ARGV.clear
  @unused.map { |j| ARGV.push(j) }
end

unless _errors > 0
  for i in @_deferred
    begin
      i.call
    rescue => e
      STDERR.puts "Action in Getopt::Declare specification produced:\n#{e}"
      _errors += 1
    end
  end
end

!(_errors>0)  # return true or false (false for errors)

