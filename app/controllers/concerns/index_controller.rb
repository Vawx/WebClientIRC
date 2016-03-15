require "#{Rails.root}/lib/irc_main/irc_main.rb"

class IndexController < ApplicationController
  attr_accessor :irc_main, :message_log
  define_method :initialize do
    @message_log = Array.new
    @irc_main = IRCMain.new self
  end

  define_method :read do |message|
    @message_log.push message
     if @message_log.length > 10
      @message_log.clear
     else
       puts @message_log.length
    end
  end

  define_method :index do
    render :index
  end
end