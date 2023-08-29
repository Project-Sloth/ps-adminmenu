import { writable } from "svelte/store";

export const VEHICLE_DEV = writable<VEHICLE_DATA[]>(null);
  
interface VEHICLE_DATA {
    show: boolean;
    name: string;
    model: string;
    netID: string;
    engine_health?: string;
    body_health?: string;
    plate?: string;
    fuel?: string;
    speed?: string;
}