require_relative('models/properties')
require('pry-byebug')

Property.delete_all()

property1 = Property.new({'address' => '21 Academy Place', 'value' => '165000', 'num_bed' => '3', 'build' => 'flat'})
property2 = Property.new({'address' => '1 Castle Terrace', 'value' => '500000', 'num_bed' => '6', 'build' => 'townhouse'})

property1.save()
property2.save()
property2.value = '550000'
property2.update()
# #####property1.delete()
p Property.find_by_id(property1.id)
p Property.find_by_address("1 Castle Terrace")
