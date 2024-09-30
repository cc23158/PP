package com.example.SF.BLL;

import com.example.SF.DTO.Exercise;
import com.example.SF.DTO.Muscle;
import com.example.SF.ImageService;
import com.example.SF.Repository.IExercise;
import io.micrometer.common.util.StringUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExerciseService {
    private final IExercise iExercise;
    private final MuscleService muscleService;
    private final ImageService imageService;

    @Autowired
    public ExerciseService(IExercise iExercise, MuscleService muscleService, ImageService imageService){
        this.iExercise = iExercise;
        this.muscleService = muscleService;
        this.imageService = imageService;
    }

    public List<Exercise> getAll(){
        try{
            return iExercise.findAll();
        }

        catch (Exception e){
            System.out.println("Cannot get exercises: " + e.getMessage());
            return List.of();
        }
    }

    public Exercise getById(Integer id){
        try{
            return iExercise.findById(id).orElse(null);
        }

        catch (Exception e){
            System.out.println("Cannot get exercise: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public List<Exercise> getByMuscle(Integer muscleId){
        try{
            return iExercise.getByMuscle(muscleId);
        }

        catch (Exception e){
            System.out.println("Cannot find exercise by muscle ID: " + muscleId);
            return List.of();
        }
    }

    @Transactional
    public List<Exercise> findByImage(String image) {
        try{
            return iExercise.findByImage(image);
        }

        catch (Exception e){
            System.out.println("Cannot find exercises by image: " + e.getMessage());
            return List.of();
        }
    }

    public Exercise insert(String name, String image, String path, Integer muscleId){
        if (StringUtils.isEmpty(name) || StringUtils.isEmpty(path) || muscleId == null){
            System.out.println("Name, path or muscleId must not be empty");
            return null;
        }

        try{
            Exercise exercise = new Exercise();
            exercise.setExercise_name(name);
            exercise.setExercise_path(path);
            exercise.setExercise_active(true);

            if (StringUtils.isNotEmpty(image)){
                exercise.setExercise_image(image);
            }

            Muscle muscle = muscleService.getById(muscleId);
            if (muscle == null){
                System.out.println("Muscle not found for ID: " + muscleId);
                return null;
            }
            exercise.setExercise_muscle(muscle);

            return iExercise.save(exercise);
        }

        catch (Exception e){
            System.out.println("Cannot insert exercise: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public void updateImage(Integer id, String image){
        try{
            Optional<Exercise> optionalExercise = iExercise.findById(id);
            if (optionalExercise.isPresent()){
                Exercise exercise = optionalExercise.get();
                String oldImageUrl = exercise.getExercise_image();

                exercise.setExercise_image(image);
                iExercise.save(exercise);  // Isso atualiza a entidade no banco

                // Verifica se há outras entidades usando a imagem antiga
                List<Exercise> exercisesWithOldImage = iExercise.findByImage(oldImageUrl);
                if (exercisesWithOldImage.isEmpty()){
                    imageService.deleteImageFromBucket(oldImageUrl); // Exclui a imagem se não estiver mais em uso
                }
            }

            else{
                System.out.println("Exercise not found for ID: " + id);
            }
        }

        catch (Exception e){
            System.out.println("Cannot change exercise's image: " + e.getMessage());
        }
    }

    @Transactional
    public void updatePath(Integer id, String path){
        try{
            iExercise.updatePath(id, path);
        }

        catch (Exception e){
            System.out.println("Cannot change exercise's path: " + e.getMessage());
        }
    }

    @Transactional
    public void delete(Integer id) {
        try{
            iExercise.delete(id);

            Optional<Exercise> optionalExercise = iExercise.findById(id);
            if (optionalExercise.isPresent()){
                Exercise exercise = optionalExercise.get();
                String oldImageUrl = exercise.getExercise_image();

                List<Exercise> exercisesWithOldImage = iExercise.findByImage(oldImageUrl);
                if (exercisesWithOldImage.isEmpty()){
                    imageService.deleteImageFromBucket(oldImageUrl);
                }
            }

            else{
                System.out.println("Exercise not found for ID: " + id);
            }
        }

        catch (Exception e){
            System.out.println("Cannot delete exercise: " + e.getMessage());
        }
    }
}
