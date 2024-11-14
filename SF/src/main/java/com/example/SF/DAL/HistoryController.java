package com.example.SF.DAL;

import com.example.SF.BLL.HistoryService;
import com.example.SF.DTO.Exercise;
import com.example.SF.DTO.History;
import com.example.SF.DTO.Recipe;
import okhttp3.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/history")
public class HistoryController {
    private final HistoryService historyService;

    public HistoryController(HistoryService historyService) {
        this.historyService = historyService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<History> getAll() {
        try {
            return historyService.getAll();
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @GetMapping("/getByClientNoDate")
    public List<History> getByClientNoDate(@RequestParam("clientId") Integer clientId) {
        try {
            return historyService.getByClientNoDate(clientId);
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @GetMapping("/getByClient")
    public List<History> getByClient(@RequestParam("clientId") Integer clientId, @RequestParam("date") String date) {
        try {
            LocalDate dateLocal = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            return historyService.getByClient(clientId, dateLocal);
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public ResponseEntity<String> insert(@RequestParam("clientId") Integer clientId, @RequestBody List<Recipe> recipes) {
        try {
            historyService.insert(clientId, recipes);
            return ResponseEntity.ok("Histories inserted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot insert histories");
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id) {
        try {
            historyService.delete(id);
            return ResponseEntity.ok("History deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot delete history");
        }
    }
}
