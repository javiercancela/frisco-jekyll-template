---
id: 131
title: Un vistazo a las APIs de acelerómetros (como el del N95)
date: 2007-11-17T22:08:31+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/17/un-vistazo-a-las-apis-de-acelerometros-como-el-del-n95/
categories:
  - java-me
  - symbian
image: /images/obsolete.jpg
---
He tenido tiempo de echarle un vistazo por encima a la [Sensor API](http://www.forum.nokia.com/info/sw.nokia.com/id/4284ae69-d37a-4319-bdf0-d4acdab39700/Sensor_plugin_S60_3rd_ed.html "Sensor Plug-in for 60 3rd Edition SDK for Symbian OS, for C++") de los dispositivos Nokia. También a su equivalente para Java ME, [_JSR 256: Mobile Sensor API_](http://jcp.org/en/jsr/detail?id=256 "Mobile Sensor API")_._

Ambas APIs funcionan de manera similar: ofrecen métodos para interrogar al dispositivo sobre los sensores que posee, y una vez elegido alguno lo interrogan periódicamente para obtener los valores medidos. Estos valores medidos pueden ser muchas cosas; la API de Java define una serie de nombres estándar para la cantidad medida, que nos pueden dar una idea del tipo de dispositivos para los que está pensada:

> <pre>absorbed_dose, absorbed_dose_rate, acceleration, activity, alcohol,
 altitude, amount_of_substance, amount_of_substance_concentration,
 angle, angular_acceleration, angular_velocity, area, battery_charge,
 blood_glucose_level, blood_oxygen_level, blood_pressure,
 body_fat_percentage, capacitance, catalytic_activity,
 catalytic_concentration, character, current_density, direction,
 direction_of_motion, dose_equivalent, duration, dynamic_viscosity,
 electric_charge, electric_charge_density, electric_conductance,
 electric_currency, electric_current, electric_field_strength,
 electric_flux_density, electric_potential_difference, electric_resistance,
 energy, energy_density, entropy, exposure, fingerprint, flip_state,
 force,  frequency, gesture, heart_rate, heat_capacity,
 heat_flux_density, humidity, illuminance, inductance, irradiance,
 kerma, length, location, luminance, luminous_flux, luminous_intensity,
 magnetic_field_strength, magnetic_flux, magnetic_flux_density, mass,
 mass_density, molar_energy, molar_entropy, molar_heat_capacity,
 moment_of_force, percentage, permeability, permittivity, plane_angle,
 power, pressure, proximity, quantity_of_heat, radiance, radiant_flux,
 radiant_intensity, RR_interval, solid_angle, sound_intensity, specific_energy,
 specific_entropy, specific_heat_capacity, specific_volume,
 step_count, stress, surface_tension, temperature,
 thermal_conductivity, time, wave_number, velocimeter, velocity,
 wind_speed, volume, work</pre>

La API de Nokia parece más restrictiva, diseñada para medir cosas en términos de las tres dimensiones espaciales. De hecho en la página sólo se habla de un acelerómetro. Sin embargo, me da la impresión de que es posible obtener diversos parámetros del acelerómetro. Al menos, además de la aceleración, puedes obtener ángulos de inclinación (que el acelerómetro puede proporcionar calculando la distribución de las componentes de la gravedad) como si fuese un giróscopo. En cualquier caso, esta API ya ha dado pie al desarrollo de aplicaciones tan fundamentales como [la aplicación de moda para el N95](http://www.symbian-guru.com/welcome/2007/11/lightsaber-v13.html "Lightsaber V1.3 for N95 - Improved Again").

Y para que veamos que no sólo el iPhone y el N95 tienen acelerómetro, aquí hay un ejemplo de [cómo usar la API de Java con el acelerómetro del Sony Ericsson W910](http://developer.sonyericsson.com/site/global/techsupport/tipstrickscode/java/p_jsr256sensorapi_jp8_w910.jsp "Using the Sensor API with the accelerometer for W910 in Java ME").

###Entradas relacionadas:
  
[El acelerómetro del N95]({% post_url 2007-11-02-el-acelerometro-del-n95 %})