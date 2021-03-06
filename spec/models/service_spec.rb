require File.expand_path(File.join(File.dirname(__FILE__), *%w[.. spec_helper]))

describe Service do
  describe 'attributes' do
    before :each do
      @service = Service.new
    end
    
    it 'should have a name' do
      @service.should respond_to(:name)
    end
    
    it 'should allow setting and retrieving the name' do
      @service.name = 'test name'
      @service.name.should == 'test name'
    end

    it 'should have a description' do
      @service.should respond_to(:description)
    end

    it 'should allow setting and retrieving the description' do
      @service.description = 'test description'
      @service.description.should == 'test description'
    end
  end

  describe 'validations' do
    before :each do
      @service = Service.new
    end

    it 'should require a name' do
      @service.name = nil
      @service.valid?
      @service.errors.should be_invalid(:name)
    end
    
    it 'should require name to be unique' do
      dup = Service.generate!(:name => 'unoriginal name')
      @service.name = 'unoriginal name'
      @service.valid?
      @service.errors.should be_invalid(:name)
    end

    it 'should be valid with an unique name' do
      @service.name = 'creative name'
      @service.valid?
      @service.errors.should_not be_invalid(:name)
    end
  end
  
  describe 'associations' do
    before :each do
      @service = Service.new
    end

    it 'should have many nodes' do
      @service.should respond_to(:nodes)
    end
    
    it "should allow setting and retrieving nodes" do
      @nodes = Array.new(3) { Node.generate! }
      @service.nodes << @nodes
      @service.nodes.should == @nodes
    end
  end
end
