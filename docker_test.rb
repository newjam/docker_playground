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

hm4c_image = make_image 'hm4c'
hm4c_image.push

hm4c_container = make_container 'hm4c', '31337'

puts 'Starting docker container'
hm4c_container.start

puts  'Running solution'
puts %x{python2.7 hm4c/hm4c_solution.py}

puts 'Stopping docker container'
hm4c_container.stop

