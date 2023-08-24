import { writable } from "svelte/store";

interface REPORT_DATA {
    message: string,
    citizenid: string,
    fullname: string,
    time: number,
  }
  
  export const REPORT = writable<REPORT_DATA[]>(null);
  export const REPORTS = writable<REPORT_DATA>(null);