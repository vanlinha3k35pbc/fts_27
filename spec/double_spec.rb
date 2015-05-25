RSpec.describe "A test double" do
  it "returns canned responses from the methods named in the provided hash" do
    books = []
    books << instance_double("Book", :rspec_book, :pages => 250)
    books << instance_double("Book", "(Untitled)", :pages => 5000)
    debugger
  end
end
