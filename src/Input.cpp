#include <Input.h>
#include <GameHeader.h>
//#include <Windows.h>
#include <memory>
#include <iostream>

Input::Input() {
  memset(this, 0, sizeof(Input));
}

void Input::EndFrame() {
  memset(key_press, 0, sizeof(key_press));
  memset(mouse_button_press, 0, sizeof(mouse_button_press));
  mouse_dx = mouse_dx * GH_MOUSE_SMOOTH + mouse_ddx * (1.0f - GH_MOUSE_SMOOTH);
  mouse_dy = mouse_dy * GH_MOUSE_SMOOTH + mouse_ddy * (1.0f - GH_MOUSE_SMOOTH);
  mouse_ddx = 0.0f;
  mouse_ddy = 0.0f;
}

void Input::UpdateRaw(const SDL_Event* event) {
  static Uint8 buffer[2048];
  static Uint32 buffer_size = sizeof(buffer);

  if (event->type == SDL_MOUSEMOTION) {
    mouse_ddx += event->motion.xrel;
    mouse_ddy += event->motion.yrel;
    //std::cout << "MOUSE MOTION, RELATIVES X=" << event->motion.xrel << " Y=" << event->motion.yrel << "\n";
  } else if (event->type == SDL_MOUSEBUTTONDOWN) {
    //if (raw->data.mouse.usButtonFlags & RI_MOUSE_LEFT_BUTTON_DOWN) {
    if (event->button.button == SDL_BUTTON_LEFT) {
      mouse_button[0] = true;
      mouse_button_press[0] = true;
    }
    //if (raw->data.mouse.usButtonFlags & RI_MOUSE_MIDDLE_BUTTON_DOWN) {
    if (event->button.button == SDL_BUTTON_MIDDLE) {
      mouse_button[1] = true;
      mouse_button_press[1] = true;
    }
    //if (raw->data.mouse.usButtonFlags & RI_MOUSE_RIGHT_BUTTON_DOWN) {
    if (event->button.button == SDL_BUTTON_RIGHT) {
      mouse_button[2] = true;
      mouse_button_press[2] = true;
    }
  } else if (event->type == SDL_MOUSEBUTTONUP) {
    if (event->button.button == SDL_BUTTON_LEFT) mouse_button[0] = false;
    if (event->button.button == SDL_BUTTON_MIDDLE) mouse_button[1] = false;
    if (event->button.button == SDL_BUTTON_RIGHT) mouse_button[2] = false;
  } //else if (raw->header.dwType == RIM_TYPEHID) {
    //TODO:
  //}
}
