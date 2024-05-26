
package lastproject;

public class Teacher {
    private String fullName;
    private String username;
    private String password;
    private String gender;
    private int experience;
    private String educationLevel;
    private String FieldOfStudy;
    private String email;
    private String phone;
    private String department;
    private String role;

    // Constructor
    public Teacher(String fullName, String username, String password, String gender, int experience,
                   String educationLevel, String FieldOfStudy, String email, String phone, String department, String role) {
        this.fullName = fullName;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.experience = experience;
        this.educationLevel = educationLevel;
        this.FieldOfStudy = FieldOfStudy;
        this.email = email;
        this.phone = phone;
        this.department = department;
        this.role = role;
    }

 
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public String getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(String educationLevel) {
        this.educationLevel = educationLevel;
    }

     public String getFieldOfStudy() {
        return FieldOfStudy;
    }

    public void setFieldOfStudy(String FieldOfStudy) {
        this.FieldOfStudy = FieldOfStudy;
    }

    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

   
}

