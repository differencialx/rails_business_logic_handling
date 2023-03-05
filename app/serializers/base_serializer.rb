class BaseSerializer
  include Alba::Resource

  transform_keys :lower_camel
end
