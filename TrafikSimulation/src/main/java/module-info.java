module org.openjfx.trafiksimulation {
    requires javafx.controls;
    requires javafx.fxml;

    opens org.openjfx.trafiksimulation to javafx.fxml;
    exports org.openjfx.trafiksimulation;
}
