package com.example.SF.DAL;

import com.example.SF.BLL.HistoryService;
import com.example.SF.DTO.Exercise;
import com.example.SF.DTO.History;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalTime;
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
    @GetMapping("/getByClient")
    public List<History> getByClient(@RequestParam("clientId") Integer clientId) {
        try {
            return historyService.getByClient(clientId);
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public History insert(@RequestParam("clientId") Integer clientId, @RequestParam("recipeId") Integer recipeId, @RequestParam("time") LocalTime time) {
        return historyService.insert(clientId, recipeId, time);
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id) {
        try {
            historyService.delete(id);
            return ResponseEntity.ok().body("History deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot delete history");
        }
    }
}
