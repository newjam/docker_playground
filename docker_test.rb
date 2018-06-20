require 'docker'

# proof of concept for building and running challenges in docker containers from ruby

# analogous to 'docker build -t name name'
def make_image name
  puts "Creating docker image #{name}"
  image = Docker::Image.build_from_dir(name)
  image.tag('repo' => name, 'tag' => 'latest')
  image
end

# analogous to 'docker run -t -p port:port name'
def make_container name, port
  puts "Creating docker containeri #{name}"
  hm4c_container = Docker::Container.create(
    'Image' => 'hm4c',
    'ExposedPorts' => { "#{port}/tcp" => {} },
    'HostConfig' => {
      'PortBindings' => {
        "#{port}/tcp" => [{ 'HostPort' => port }]
      }
    }
  )
end

def stuff name, port, solution
  image = make_image name
  image.push

  container = make_container name, port

  puts 'Starting docker container'
  container.start

  puts 'Running solution'
  puts %x{#{solution}}

  puts 'Stopping docker container'
  container.stop
end

stuff 'hm4c', '31337', 'python2.7 hm4c/hm4c_solution.py'
stuff 'cpushop', '43000', 'python2.7 cpushop/cpushop_solution.py'
