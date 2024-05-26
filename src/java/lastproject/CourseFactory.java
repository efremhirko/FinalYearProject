package lastproject;

public class CourseFactory {
    public Course createCourse(String courseCode, String courseTitle, int ects, int lectureHours, int tutorialHours,
                               int labHours, int batch, String semester, String department) {
        return new Course(courseCode, courseTitle, ects, lectureHours, tutorialHours, labHours, batch, semester, department);
    }
}
