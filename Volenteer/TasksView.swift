import SwiftUI
import SDWebImageSwiftUI


struct BlogPostCardMain: View {
    @StateObject var model = ViewModel()

 

    var body: some View {
        
        VStack{
            ScrollView{
                ForEach(model.jobs) { job in
                    PostCard(img: job.img, creator: job.creator,name: job.name,hours:job.hours,onlyverified:job.onlyverified, des:job.des,documentID: job.id)
                }
            }
            Button("Reload"){
                model.getData()
            }.buttonStyle(GrowingButton())
        }

            .onAppear(){

                    model.getData()

                
            }
           

    }
    }


struct PostCard:View{
    @Environment(\.colorScheme) var colorScheme
    @State var img:String
    @State var creator:String
    @State var name:String
    @State var hours:String
    @State var onlyverified:Bool
    @State var profile_pic = ""
    @State var edittitle = ""
    @State var editdes = ""
    @State var showingSuccsessAlert = false
    @State var des :String
    @State var documentID:String
    @State var edit = false
    @State var nameerror = false
    @State var msg:String = ""
    @State var showAlert = false
    @State var editFinishedAlert = false
    @State var cantrequest = false
//    init(){
//        self.edittitle = self.name
//    }
    var body: some View{
        VStack(alignment: .leading) {

                    WebImage(url: URL(string: img))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 190)
                        .frame(maxWidth: UIScreen.main.bounds.width - 80)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            Spacer()
                    VStack(spacing: 6) {
                        HStack {
                            Text(name)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(3)
                                .font(Font.title2.bold())
                                .foregroundColor(.primary)

                            Spacer()
                            if creator == username{
                                Button(action: {
                                    edittitle=name
                                    editdes=des
                                    edit.toggle()
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        HStack {
                            Text(des)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(3)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .foregroundColor(.secondary)
                            
                        }
                        HStack{
                            WebImage(url: URL(string: profile_pic))
                                .resizable()
                                .cornerRadius(40)
                                .frame(width: 50, height: 50)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                            Spacer()
                            Button("Request") {
                                if onlyverified == true{
                                    if verified == true{
                                        print("Button pressed!")
                                        showAlert.toggle()
                                    }
                                    else{
                                        cantrequest.toggle()
                                    }
                                }
                                else{
                                    showAlert.toggle()
                                }
                            
                            }
                            .buttonStyle(GrowingButton())
                       

                        }
                    }
                    .frame(height: 110)
                   
        }
        .padding(15)
        .background(colorScheme == .dark ? Color("#121212") : Color.white)
        .frame(maxWidth: UIScreen.main.bounds.width - 50, alignment: .leading)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
        .onAppear(){
            Task{
                self.profile_pic = await getProfileUrl(username: self.creator)
            }
            
            
        }

        
        .sheet(isPresented: $showAlert, onDismiss: nil){
            Form{
                Section(){
                    Text("Thankyou for accepting this job! Please write a personal message to \(creator) telling them that you are willing to help them.")
                }
                Section{
                    TextField("Send a personalized message!", text: $msg)
                   
//                        .textFieldStyle(PlainTextFieldStyle())
//                        .padding([.horizontal], 4)
//                        .cornerRadius(16)
//                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
//                        .padding([.horizontal], 24)
                }
                Section{
                    Button("Send") {
                        createInboxRow(helper: username, creator: creator, name: name, job_id: documentID, date_accepted: Date.now, msg: msg,job_name: name,hours:hours)
                        showingSuccsessAlert.toggle()
                        showAlert.toggle()
                    }
                    .buttonStyle(GrowingButton())
                }
            }
        }
        
        
        .sheet(isPresented: $edit, onDismiss: nil){
            Form{
                Section(){
                    Text("Edit Task : \(name)").bold().font(.title2)
                }
                Section{
                    Text("Title")
                    TextField("New Title", text: $edittitle)
                   
//                        .textFieldStyle(PlainTextFieldStyle())
//                        .padding([.horizontal], 4)
//                        .cornerRadius(16)
//                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
//                        .padding([.horizontal], 24)
                }
                Section{
                    Text("Description")
                    TextField("New Description", text: $editdes)
                }

                Section{
                    Button("Save") {
                        Task{
                            edit.toggle()
                            if name == ""{
                                nameerror=true
                                
                            }
                            else{
                                name = edittitle
                                des = editdes
                                await editTask(documentID: documentID, title: edittitle, des: editdes)
                                editFinishedAlert.toggle()
                            }
                        }
                
                    }
                    .buttonStyle(GrowingButton())
                }
            }
        }
        
        
        
        
        
        
        .alert("Accept sent to \(creator)!", isPresented: $showingSuccsessAlert) {
            Button("OK", role: .cancel) { }
        }
        
        .alert("Task Edited!", isPresented: $editFinishedAlert) {
            Button("OK", role: .cancel) { }
        }
        
        
        .alert("Please fill in name!", isPresented: $nameerror) {
            Button("OK", role: .cancel) { }
        }
        .alert("Sorry, you have to be verified to request this job. To become verified, go to your profile tab and upload your drivers license.", isPresented: $cantrequest) {
            Button("OK", role: .cancel) { }
        }
    }
}
