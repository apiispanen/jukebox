
import banana_dev as banana

model_inputs = {
  "prompt": "scenery, village, outdoors, sky, clouds",
  "num_inference_steps": 50,
  "guidance_scale": 7
}

api_key = "1f93362c-0751-4b96-aae6-979158faa9f1"
model_key = "e7e231f6-0424-4ed5-b369-3e5b1d63ad51"

# Run the model
out = banana.run(api_key, model_key, model_inputs)

