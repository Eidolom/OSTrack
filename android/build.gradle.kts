import com.android.build.api.dsl.LibraryExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    plugins.withId("com.android.library") {
        extensions.configure<LibraryExtension> {
            if (namespace == null) {
                val sanitizedProjectName = project.name.replace(Regex("[^A-Za-z0-9_]"), "_")
                namespace = "dev.ostrack.generated.$sanitizedProjectName"
            }
        }
    }

    if (project.name == "isar_flutter_libs") {
        // AGP 8+ forbids using the AndroidManifest package attribute as namespace.
        val manifestFile = project.file("src/main/AndroidManifest.xml")
        if (manifestFile.exists()) {
            val original = manifestFile.readText()
            val patched = original.replace(Regex("\\s+package=\"[^\"]+\""), "")
            if (patched != original) {
                manifestFile.writeText(patched)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
