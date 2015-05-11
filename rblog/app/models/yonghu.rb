class Yonghu < ActiveRecord::Base
validates_presence_of :xingming,:gongsimingcheng,:quhao,:gongsidianhua,:shouji,:qq
validates_length_of :shouji, :in => 11..12

end
