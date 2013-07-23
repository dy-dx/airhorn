class Airhorn
  def self.blow (args)
    pid = spawn("afplay -t 1.4 #{audio_file_path('airhorn.wav')}")
    tpid = spawn('printf "B"; while sleep 0.1; do printf "R"; done')
    Process.wait pid
    Process.kill 'TERM', tpid
    return
  end

  def self.audio_file_path (file)
    File.expand_path("../../audio/#{file}", __FILE__)
  end

end
