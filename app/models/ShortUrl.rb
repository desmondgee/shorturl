class ShortUrl < ActiveRecord::Base
  validates :forward, presence: true
  
  # Used to generate a unique hash for a given integer in
  #  a reversable process.
  # https://github.com/peterhellberg/hashids.rb
  @@hashids = Hashids.new("the salt is real", 5)
  
  # Use to find id of the ShortUrl given a code.
  # Returns nil if not valid.
  def self.codeToId(code)
    arr = @@hashids.decode(code.to_s)  # decode calls .empty? which will crash on integers and nil, so convert to string.
    if arr.length == 1
      return arr[0]
    else
      return nil
    end
  end
  
  # Returns the shortened url code
  def code
    return (self.id.is_a?(Integer) ? @@hashids.encode(self.id) : '')
  end
  
end
