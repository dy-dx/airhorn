class Airhorn
  def self.blow (file = 'airhorn.wav', duration = 1.5)
    pid = play audio_file_path(file), duration
    return if pid.nil?
    tpid = spawn('printf "B"; while sleep 0.1; do printf "R"; done')
    Process.wait pid
    Process.kill 'TERM', tpid
    return
  end

  def self.play (file_path, duration)
    if system 'command -v afplay >/dev/null 2>&1'
      # mac
      spawn("afplay -t #{duration.to_s} #{file_path} >/dev/null 2>&1")
    elsif system 'command -v aplay >/dev/null 2>&1'
      # linux
      spawn("aplay -d #{duration.ceil.to_s} #{file_path} >/dev/null 2>&1")
    end
  end

  def self.audio_file_path (file)
    File.expand_path("../../audio/#{file}", __FILE__)
  end

end
