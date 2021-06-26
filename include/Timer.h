#pragma once
//#include <Windows.h>
#include <SDL2/SDL.h>

class Timer {
public:
  Timer() {
    //QueryPerformanceFrequency(&frequency);
  }

  void Start() {
    //QueryPerformanceCounter(&t1);
    t1 = SDL_GetTicks();
  }

  float Stop() {
    //QueryPerformanceCounter(&t2);
    t2 = SDL_GetTicks();
    //return float(t2.QuadPart - t1.QuadPart) / frequency.QuadPart;
    return float(t2 - t1) / 1000.0f;
  }

  int64_t GetTicks() {
    //QueryPerformanceCounter(&t2);
    t2 = SDL_GetTicks();
    //return t2.QuadPart;
    return t2;
  }

  int64_t SecondsToTicks(float s) {
    //return int64_t(float(frequency.QuadPart) * s);
    return int64_t(1000.0f * s);
  }

  float StopStart() {
    //const float result = Stop();
    const float result = Stop();
    t1 = t2;
    return result;
  }

private:
  //LARGE_INTEGER frequency;        // ticks per second
  //LARGE_INTEGER t1, t2;           // ticks
  Uint32 t1, t2;
};
