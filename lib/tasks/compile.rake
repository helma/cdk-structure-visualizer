namespace :visualizer do

  desc "Compile cdk visualizer"
  task :compile do
    sh "cd lib/java; make"
  end

end

