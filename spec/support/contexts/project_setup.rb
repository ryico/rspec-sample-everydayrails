RSpec.shared_context 'project setup' do
  let(:user) { create(:user) }
  let(:project) { create(:project, owner: user) }
  let(:task) { create(:task, project: project, name: 'Test task') }
end
