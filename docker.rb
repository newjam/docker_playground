require 'docker'

# proof of concept for building and running challenges in docker containers from ruby


puts 'Creating docker image'

hm4c_image = Docker::Image.build_from_dir('hm4c')
hm4c_image.tag('repo' => 'hm4c', 'tag' => 'latest')
hm4c_image.push

puts 'Creating docker container'

hm4c_container = Docker::Container.create(
  'Image' => 'hm4c',
  'ExposedPorts' => { '31337/tcp' => {} },
  'HostConfig' => {
    'PortBindings' => {
      '31337/tcp' => [{ 'HostPort' => '31337' }]
    }
  }
)

puts 'Starting docker container'

hm4c_container.start

puts  'Running solution'
puts %x{python2.7 hm4c/hm4c_solution.py}

puts 'Stopping docker container'
hm4c_container.stop

