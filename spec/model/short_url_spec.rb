require "spec_helper"
require "ShortUrl"

describe ShortUrl do
  describe 'for hash generation' do
    it "gives different hash values from different ids" do
      dict = {}
      i = 1
      while (i<9000) 
      
        s = ShortUrl.new({:id => i})
        h = s.code
        #puts s.id
        expect(dict[h]).to be_nil
        dict[h] = true
        
        i += 1
      end
      
    end
    it "correctly revert hashes back to ids" do
      [1,4,15,503,10821,472196].each do |i|
        s = ShortUrl.new({:id=>i})
        h = s.code
        expect(ShortUrl.codeToId(h)).to eq(i)
      end
    end
    it "should return nil for for at least some incorrect hashes" do
      expect(ShortUrl.codeToId("lasfdkj2")).to be_nil
    end

  end
end
