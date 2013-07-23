class Airhorn
  def self.blow (args)
    pid = play audio_file_path('airhorn.wav')
    return if pid.nil?
    tpid = spawn('printf "B"; while sleep 0.1; do printf "R"; done')
    Process.wait pid
    Process.kill 'TERM', tpid
    return
  end

  def self.play (file_path)
    if system 'command -v afplay >/dev/null 2>&1'
      # mac
      spawn("afplay -t 1.4 #{file_path}")
    elsif system 'command -v aplay >/dev/null 2>&1'
      # linux
      spawn("aplay -d 1.4 #{file_path}")
    end
  end

  def self.audio_file_path (file)
    File.expand_path("../../audio/#{file}", __FILE__)
  end

end
