require 'socket'

class IRCBot
  attr_accessor :nick, :channel, :server, :socket, :controller
  define_method :initialize do |nick, channelName, controller|
    @controller = controller
    @nick = nick
    if channelName[ 0 ] == '#'
      @channel = channelName
    end
    @server = 'irc.freenode.net'
    @socket = TCPSocket.open @server, 6667

    say "NICK #{@nick}"
    say "USER #{@nick} 0 * :This is a bot!"
    say "JOIN #{@channel}"
  end

  define_method :say do |message|
    puts message
    @socket.puts message
  end

  define_method :say_channel do |messsage|
    puts "PRIVMSG #{@channel} #{message}"
    say "PRIVMSG #{@channel} #{message}"
  end

  define_method :join do |channel|
    @channel = '#' + channel unless channel[ 0 ] == '#'
    say "JOIN #{@channel}"
  end

  define_method :part do |channel|
    @channel = '#' + channel unless channel[ 0 ] == '#'
    say "PART #{@channel}"
  end

  define_method :run do
    begin
    message = @socket.read_nonblock(1024)
    @controller.read message
    puts message
    if message.match /^PING :(.*)$/
      say "PONG #{$~[1]}"
    end
    rescue
      return
    end
  end
end