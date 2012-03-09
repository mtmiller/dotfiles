# -*- mode: ruby -*- vi:set ft=ruby:

%w(rubygems).each do |lib|
  begin
    require lib
  rescue LoadError
  end
end

IRB.conf[:LOAD_MODULES] |= %w(irb/completion)
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.irb_history')
IRB.conf[:SAVE_HISTORY] = 1000
